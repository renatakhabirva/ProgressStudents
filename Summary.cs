//------------------------------------------------------------------------------
// <auto-generated>
//     Этот код создан по шаблону.
//
//     Изменения, вносимые в этот файл вручную, могут привести к непредвиденной работе приложения.
//     Изменения, вносимые в этот файл вручную, будут перезаписаны при повторном создании кода.
// </auto-generated>
//------------------------------------------------------------------------------

namespace ProgressStudents
{
    using System;
    using System.Collections.Generic;
    
    public partial class Summary
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Summary()
        {
            this.SubordinatesSummary = new HashSet<SubordinatesSummary>();
        }
    
        public int SummaryID { get; set; }
        public int SummaryClass { get; set; }
        public int SummaryTeacher { get; set; }
        public int SummaryDiscipline { get; set; }
        public int SummarySemester { get; set; }
    
        public virtual Class Class { get; set; }
        public virtual Discipline Discipline { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<SubordinatesSummary> SubordinatesSummary { get; set; }
        public virtual Teachers Teachers { get; set; }
    }
}
